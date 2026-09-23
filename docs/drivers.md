# Writing and tuning petit drivers

petit parses text with an **entry driver** (`petit/CrunchLog.py`), which picks
out timestamp, host, daemon and payload, then turns each entry into a
fingerprint with a **hash driver** (`petit/LogHash.py`). Entries that share a
fingerprint are one group. How aggressive a hash driver is decides what a
reader ever gets to see, so this page is about getting that right.

## What a hash driver declares

```python
class SecureLogHash(SuperHash):
    KEY_FIELDS = ("daemon", "log_entry")        # fields joined into the key
    GENERALIZATIONS = [(re.compile(...), "...")]  # format phrases, applied first
    DEFAULT_FILTER = "hash.stopwords"           # stopword file, applied second
```

The key for an entry is its `KEY_FIELDS` joined by a space, with
`GENERALIZATIONS` applied, then scrubbed by the filter. Nothing is ever
written back to the entry.

`DEFAULT_FILTER` is the driver's decision, not the caller's. `analyze_text`
uses it unless the caller passes `filter_name=` or `stopwords=` explicitly;
those still win.

| Hash driver     | KEY_FIELDS               | DEFAULT_FILTER     |
|-----------------|--------------------------|--------------------|
| `SyslogHash`    | `daemon`, `log_entry`    | `hash.stopwords`   |
| `SecureLogHash` | `daemon`, `log_entry`    | `hash.stopwords`   |
| `ApacheLogHash` | `log_entry`              | `hash.stopwords`   |
| `SnortLogHash`  | `log_entry`              | `hash.stopwords`   |
| `RawLogHash`    | `log_entry`              | `strict.stopwords` |
| `DaemonHash`    | `daemon`                 | `daemon.stopwords` |
| `HostHash`      | `host`                   | `host.stopwords`   |

## The rule for generalizations

> **A generalization is a claim that everything after this phrase is a
> parameter, not a message. Normalize what the FORMAT generated; keep what a
> HUMAN wrote.**

Ask a rule two questions, in order.

1. **Does it collapse a token or a phrase?** Token-level rules (timestamps,
   IP addresses, hex, PIDs) are always safe, because a token cannot carry a
   sentence. Phrase-level rules are allowed only when the tail they swallow is
   drawn from a bounded, machine-generated vocabulary.
2. **What is the widest thing this rule's `.*` can swallow?** If the format
   allows free text there, the rule is too wide.

Applied to sshd: `Invalid user.*` used to swallow the user name and
everything after it. The user name is chosen by whoever is connecting, so it
can hold anything, including text written to be read by whatever reads the
log. The rule is now `Invalid user (\S+) from \S+` → `Invalid user \1 from #`:
the name stays, only the source address goes, and a name with a space in it
doesn't match at all rather than being swallowed.

## Stopword files

Filter files live in `petit/data/filters/`, one rule per line, applied in
order. A line is either a bare regex, replaced with `#`, or
`regex<TAB>replacement`:

```
\b(?:\d{1,3}\.){3}\d{1,3}\b	<IP>
[0-9]+
```

Order matters: put specific shapes before general ones, or a timestamp
becomes six numbers.

- **`hash.stopwords`** is tuned for system logs and is deliberately
  aggressive: after `[0-9]+` → `#`, the rules `[a-f]+#` and `#[a-f]+` also
  collapse hex letters next to a number, so `bob0` and `boa0` share a
  fingerprint. That's right for spotting a flapping daemon, and wrong for
  identifiers.
- **`strict.stopwords`** normalizes only unambiguous shapes: ISO-8601, syslog,
  date and time stamps → `<TS>`, UUIDs → `<UUID>`, dotted quads → `<IP>`, `0x`
  hex and hex runs of 8+ containing a letter → `<HEX>`, standalone numbers →
  `<N>`. A number attached to a word or a dash (`web01`, `PROJ-1234`) is part
  of an identifier and stays.

Every regex in a filter or generalization table must be linear-time: use
character classes and bounded repetition, and no nested quantifiers. petit
runs these over text it didn't write.

## Settling an argument about a driver

`test/test_drivers.py` has one class per hash driver with `MERGE` and
`NO_MERGE` lists of `(line_a, line_b, reason)`. If a driver collapses too
much or too little, add the pair that shows it and change the driver until
the table passes.

## Fingerprint corpora (`--fingerprint`, `collapse_fingerprints=True`)

A fingerprint corpus is a log of one routine event, such as a reboot, stored as
`<name>.fp`. When more than 31% of a corpus's fingerprints appear in the input,
every matching group is removed and replaced by one group named after the
corpus. `Analysis.fingerprints_matched` lists what matched.

Corpora are read from every one of these directories: the packaged
`petit/data/fingerprints/`, then `/var/lib/petit/fingerprints/`,
`/usr/local/petit/var/lib/fingerprints/` and `/opt/petit/var/lib/fingerprints/`.
Where two files share a name, the earlier directory wins. Corpora are parsed
once per process and cached by path and modification time.

To add your own:

1. Capture the event as a log in a format petit already parses. For a
   reboot on a systemd host, the shutdown is the tail of
   `journalctl -o short -b -1` and the startup is the head of
   `journalctl -o short -b 0`.
2. Trim it to the event itself, from the shutdown request through the end of
   startup, and concatenate the two.
3. Replace host names and user names you don't want to publish. The
   fingerprint normalizes numbers already.
4. Save it as `<name>.fp` in your fingerprint directory. The packaged
   corpora date from 2009–2011 (RHEL 4/5, Fedora 11, Ubuntu 9.04/10.04) and
   won't match a modern journal.
