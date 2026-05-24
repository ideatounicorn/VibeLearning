import json

with open("generate.py", "r") as f:
    content = f.read()

# Replace scenario in question 28
old_scenario = "'scenario': \"Uber is launching a feature requiring drivers to upload a photo of their vehicle inspection. Ops must manually verify these photos. The PM expects 10,000 uploads on day 1. Ops currently has 5 reviewers who can do 100 per day each. What is the PM's failure here?\""
new_scenario = "'scenario': \"Uber is launching a feature requiring drivers to upload a photo of their vehicle inspection. Ops must manually verify these photos. The PM projects the following launch volume vs Ops capacity:\\n\\n| Metric | Day 1 Projection |\\n|--------|------------------|\\n| Expected Uploads | 10,000 |\\n| Ops Reviewers | 5 |\\n| Daily capacity per reviewer | 100 |\\n\\nWhat is the PM's failure here?\""

content = content.replace(old_scenario, new_scenario)

with open("generate.py", "w") as f:
    f.write(content)

