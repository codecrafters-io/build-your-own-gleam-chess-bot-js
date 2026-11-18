In this stage, you'll prepare `ENTRY.md` for the challenge's final file check.

### The entry file

The starter includes `example.ENTRY.md` in the repository root, alongside
`your_program.sh`. When you're ready, rename it:

```sh
mv example.ENTRY.md ENTRY.md
```

The template asks for each team member's name and email, followed by a
description of how the bot works. Those fields were used for tournament entries.
If you're completing the challenge for self-study, you can leave personal
details blank. The file itself is still required to pass this check.

This challenge is deprecated. The original tournament's published submission
deadline was June 8, 2025. The file-presence check does not confirm current
tournament registration.

### Tests

The tester launches `./your_program.sh` and checks for the exact filename
`ENTRY.md` in the same directory. It checks the name's presence, not the
contents of the entry.

From your repository root, check the file locally:

```sh
test -f ENTRY.md && printf 'ENTRY.md found\n'
```

Expected output:

```text
ENTRY.md found
```

### Notes

- Keep `example.ENTRY.md` until you're ready to create `ENTRY.md`. Earlier
  startup checks require at least one of those names to be present.
