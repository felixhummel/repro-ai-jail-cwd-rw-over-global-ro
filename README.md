# ai-jail global RO-mount
See Dockerfile for setup:

- installs ai-jail 2.5.0 via mise
- creates unprivileged user alice and adds the test script

build and run docker container:
```
./run.sh
```

Expected: `~/alice/foo/` is mounted RW

Actual: `~/alice/foo/` is mounted RO

The reason can be seen in the mounts, because the last one (ro) wins:
```
/home/alice/foo /home/alice/foo rw,nosuid,nodev,relatime
/home/alice/foo /home/alice/foo ro,nosuid,nodev,relatime
```
