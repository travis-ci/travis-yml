Terms: the left side is the importing config, the right side the imported
config.

Note: It is not possible to set a merge tag on the root node of the config.
The tag would apply to the first mapped node.

With these configs

```
# .travis.yml
import:
- source: ./other.yml
  mode: deep_merge

# other.yml
script: echo Hello from other.yml
```

Gatekeeper will `POST` the following config parts to travis-yml `/parse`:

```
[
  {
    "source": "owner/repo/.travis.yml@ac73e1d7b2d81609",
    "config": "import:\n- source: ./other.yml\n  mode: deep_merge\n",
    "merge_mode": "merge"
  }
  {
    "source": "owner/repo/other.yml@ac73e1d7b2d81609",
    "config": "script: echo Hello from other.yml",
    "merge_mode": "deep_merge"
  }
]
```

This is because each import can have a merge mode, so the `merge_mode` from the
import config's `import` section needs to be set on the imported config (right
side).
