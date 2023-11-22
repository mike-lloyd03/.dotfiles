#!/usr/bin/env python3
import json
from typing import List, NamedTuple

import yaml


class Config(NamedTuple):
    title: str
    description: str
    bundle_identifiers: List[str]
    keys: List[str]


with open("config.yaml") as f:
    config = yaml.safe_load(f)

data = Config(**config)

manipulators = []
for key in data.keys:
    manipulators.append(
        {
            "description": f"C-{key}",
            "type": "basic",
            "conditions": [
                {
                    "type": "frontmost_application_if",
                    "bundle_identifiers": data.bundle_identifiers,
                }
            ],
            "from": {"key_code": key, "modifiers": {"mandatory": ["left_command"]}},
            "to": [{"key_code": key, "modifiers": ["left_control"]}],
        }
    )

output = {
    "title": data.title,
    "rules": [{"description": data.description, "manipulators": manipulators}],
}

j = json.dumps(output, indent=4)
with open("output.json", "w") as f:
    f.write(j)
