# Version Management Guide

## Overview

MAIASS supports flexible version management across multiple file formats and project types. It can handle standard files like `package.json` and `VERSION`, as well as custom version file configurations for specialized projects.

## Supported Version File Formats

### Standard Files (Auto-detected)

#### package.json
```json
{
  "name": "my-project",
  "version": "1.2.3"
}
```

#### VERSION file
```
1.2.3
```

#### Git Tags Only
If no version files exist, MAIASS uses git tags exclusively.

## Custom Version File System

MAIASS supports a configurable version file system for projects with non-standard version management needs.

### Configuration Variables

| Variable | Description | Example |
|----------|-------------|----------|
| `MAIASS_VERSION_PRIMARY_FILE` | Primary version file path | `myscript.sh` |
| `MAIASS_VERSION_PRIMARY_TYPE` | File type: `json`, `txt`, or `pattern` | `txt` |
| `MAIASS_VERSION_PRIMARY_LINE_START` | Line prefix for txt files | `# Version: ` |
| `MAIASS_VERSION_SECONDARY_FILES` | Secondary files (pipe-separated) | `style.css:txt:Version: \|functions.php:pattern:define('VERSION','{version}');` |

### File Types

#### JSON Files (`json`)
Automatically updates the `"version"` property:
```json
{
  "name": "my-app",
  "version": "1.2.3"  // <- Updated automatically
}
```

#### Text Files (`txt`)
Updates lines starting with the specified prefix:
```bash
# Version: 1.2.3  // <- Line updated
echo "My Script v1.2.3"
```

#### Pattern Files (`pattern`)
Uses intelligent pattern replacement with `{version}` placeholder:
```php
<?php
define('MYTHEME_VERSION', '1.2.3');  // <- Pattern matched and updated
```

### Configuration Examples

#### WordPress Theme
```bash
# .env configuration
MAIASS_VERSION_PRIMARY_FILE="style.css"
MAIASS_VERSION_PRIMARY_TYPE="txt"
MAIASS_VERSION_PRIMARY_LINE_START="Version: "
MAIASS_VERSION_SECONDARY_FILES="functions.php:pattern:define('MYTHEME_VERSION','{version}');"
```

**style.css:**
```css
/*
Theme Name: My Theme
Version: 1.2.3
*/
```

**functions.php:**
```php
<?php
define('MYTHEME_VERSION', '1.2.3');
```

#### Shell Script Project
```bash
# .env configuration
MAIASS_VERSION_PRIMARY_FILE="myscript.sh"
MAIASS_VERSION_PRIMARY_TYPE="txt"
MAIASS_VERSION_PRIMARY_LINE_START="# Version: "
```

**myscript.sh:**
```bash
#!/bin/bash
# Version: 1.2.3
echo "Script version 1.2.3"
```

#### Multi-File Project
```bash
# .env configuration
MAIASS_VERSION_PRIMARY_FILE="package.json"
MAIASS_VERSION_PRIMARY_TYPE="json"
MAIASS_VERSION_SECONDARY_FILES="README.md:txt:Version |config.yml:txt:version: |app.py:txt:__version__ = '"
```

### Supported Line Formats (txt type)

| Format | Example Line | Configuration |
|--------|--------------|---------------|
| Shell comment | `# Version: 1.2.3` | `# Version: ` |
| YAML/Config | `version: 1.2.3` | `version: ` |
| Python | `__version__ = '1.2.3'` | `__version__ = '` |
| CSS comment | `/* Version: 1.2.3 */` | `/* Version: ` |
| WordPress style | `Version: 1.2.3` | `Version: ` |

### Pattern Matching (pattern type)

For complex version patterns, use the `pattern` type with `{version}` placeholder:

#### PHP Constants
```bash
# Configuration
MAIASS_VERSION_SECONDARY_FILES="functions.php:pattern:define('VERSION','{version}');"

# File content (before)
define('VERSION', '1.2.2');

# File content (after maiass minor)
define('VERSION', '1.3.0');
```

#### JavaScript Constants
```bash
# Configuration
MAIASS_VERSION_SECONDARY_FILES="config.js:pattern:const VERSION = '{version}';"

# File content
const VERSION = '1.2.3';
```

#### Multiple Pattern Files
```bash
# Multiple files with pipe separator
MAIASS_VERSION_SECONDARY_FILES="functions.php:pattern:define('VERSION','{version}');|config.js:pattern:const VERSION = '{version}';"
```

## Version Bumping

### Semantic Versioning

MAIASS follows [Semantic Versioning](https://semver.org/) (SemVer):

- **MAJOR** version: Incompatible API changes
- **MINOR** version: Backwards-compatible functionality additions
- **PATCH** version: Backwards-compatible bug fixes

### Usage Examples

```bash
# Bump patch version (1.2.3 → 1.2.4)
maiass
maiass patch

# Bump minor version (1.2.3 → 1.3.0)
maiass minor

# Bump major version (1.2.3 → 2.0.0)
maiass major

# Set specific version
maiass 2.1.0
```

### Version Validation

MAIASS validates version numbers:
- Must follow semantic versioning format (X.Y.Z)
- New version must be greater than current version
- Prevents duplicate git tags
- Handles missing or malformed version files gracefully

## Git Tag Management

### Automatic Tagging
- Creates git tags for all version changes
- Format: `v1.2.3` or `1.2.3` (adapts to existing pattern)
- Prevents duplicate tags
- Handles tag conflicts gracefully

### Tag Validation
```bash
# MAIASS checks for existing tags
git tag -l "v1.2.3"

# If tag exists, prompts for action:
# - Skip tagging
# - Force update tag
# - Cancel operation
```

## Repository Compatibility

MAIASS adapts to different repository structures:

| Repository Type | Version Behavior |
|----------------|------------------|
| **Full Git Flow** | Updates version files → creates tags → merges through branches |
| **Simple Workflow** | Updates version files → creates tags → offers merge to main |
| **Local Only** | Updates version files → creates local tags only |
| **No Version Files** | Creates git tags only, skips file updates |
| **First Version** | Creates initial version files and tags |

## Troubleshooting

### Common Issues

**"Version file not found"**
- Check file path in `MAIASS_VERSION_PRIMARY_FILE`
- Ensure file exists and is readable
- Verify working directory

**"Invalid version format"**
- Ensure version follows X.Y.Z format
- Check for extra characters or spaces
- Validate current version in files

**"Version not updated"**
- Check file permissions (write access)
- Verify line prefix for txt files
- Test pattern matching for pattern files

**"Git tag already exists"**
- Choose different version number
- Delete existing tag: `git tag -d v1.2.3`
- Use force update option when prompted

### Debug Mode

```bash
export MAIASS_DEBUG="true"
export MAIASS_VERBOSITY="debug"
maiass patch

# Shows detailed version file processing
# Displays git tag operations
# Reveals pattern matching results
```

## Best Practices

1. **Consistent versioning**: Use same format across all files
2. **Test configurations**: Verify version updates in non-production branches
3. **Backup important files**: Version file updates are irreversible
4. **Use semantic versioning**: Follow SemVer principles for version increments
5. **Document custom patterns**: Comment complex pattern configurations