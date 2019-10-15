# OBS - Current Date Plugin
OBS Plugin - Current date in YYYY-MM-DD is returned whenever the plugin/source is activated. Prefix/Suffix text is optionally added

Examples:
```
Default: 2019-10-12
With Prefix: Current Date: 2019-10-12
With Suffix: 2019-10-12 is the current date
With Prefix & Suffix: Current Date: 2019-10-12 is the current date
```

## Plugin Installation Instructions

- Open OBS

- Create a new Source with the type being `Text (FreeType 2)`, name it whatever you wish (e.g. Current Date)

![create_source](screenshots/create_source.png)
![name_source](screenshots/name_source.png
)

- Tools -> Scripts menu

![create_obs_source](screenshots/create_new_source.png)

- Load this script via the `+` sign and import the script

![load_source_script](screenshots/load_script.png)
![target_source_script](screenshots/target_source_script.png)
![loaded_source_script](screenshots/loaded_source_script.png)

- Once loaded, target the `Text Source` to equal the title of the source (e.g Current Date)

![target_text_source](screenshots/target_text_source.png)
![current_text_source](screenshots/current_date_text.png)

- Any updates to `Prefix Text` or `Suffix Text` should be reloaded by turning the source off and then on again for the changes to take effect

