# MAIASS Messaging System

This document describes the messaging system in MAIASS, including recent improvements to verbosity control, debug settings, and formatting.

## Overview

The MAIASS messaging system provides several functions for displaying information to the user with different levels of importance and detail. The system supports different verbosity levels to control how much information is shown.

## Verbosity Levels

MAIASS supports three verbosity levels, controlled by the `MAIASS_VERBOSITY` environment variable:

- `brief`: Shows only essential messages
- `normal`: Shows essential and normal messages (default)
- `debug`: Shows all messages, including detailed debugging information

Example:
```bash
export MAIASS_VERBOSITY="debug"
./maiass.sh patch
```

## Message Functions

### print_always

The `print_always` function displays messages that are always shown regardless of the verbosity level. Use this for important information that should never be hidden.

```bash
print_always "This message is always shown"
```

### print_info

The `print_info` function displays informational messages with verbosity level support. It takes a message and an optional level parameter.

```bash
print_info "Normal information message"  # Default level is "normal"
print_info "Essential information" "brief"
print_info "Detailed debug information" "debug"
```

### Other Message Functions

- `print_success`: Displays success messages
- `print_warning`: Displays warning messages
- `print_error`: Displays error messages (uses bold for emphasis)
- `print_section`: Displays section headers

## Debug Mode (Deprecated)

The `debug_mode` boolean (controlled by `MAIASS_DEBUG`) is deprecated in favor of using `MAIASS_VERBOSITY="debug"`. For backward compatibility, setting `MAIASS_DEBUG=true` will be treated the same as `MAIASS_VERBOSITY="debug"`, but a deprecation notice will be logged.

## Formatting Guidelines

To maintain a clean and consistent user interface:

1. Use bold formatting (`BColor`) only for emphasis and important messages
2. Use regular formatting (`Color`) for standard messages
3. Use appropriate colors for different types of messages:
   - Cyan: Informational messages
   - Green: Success messages
   - Yellow: Warning messages
   - Red: Error messages (bold for emphasis)
   - White: Section headers

## Implementation Details

### Color Definitions

The script defines both bold and regular color variables:

```bash
# Bold colors (for emphasis and important messages)
BCyan='\033[1;36m'      # Bold Cyan
BRed='\033[1;31m'       # Bold Red
# ...

# Regular colors (for standard messages)
Cyan='\033[0;36m'       # Cyan
Red='\033[0;31m'        # Red
# ...
```

### Verbosity Control

The `print_info` and `run_git_command` functions use the verbosity level to determine what to display:

```bash
case "$effective_verbosity" in
    "brief")
        # Only show essential messages
        # ...
    "normal")
        # Show brief and normal messages
        # ...
    "debug")
        # Show all messages
        # ...
esac
```

## Best Practices

1. Use `print_always` for messages that should always be shown regardless of verbosity
2. Use `print_info` with appropriate level for most messages:
   - `"brief"` for essential information
   - `"normal"` for standard information
   - `"debug"` for detailed debugging information
3. Use `print_error` for error messages that require attention
4. Use `print_warning` for warning messages
5. Use `print_success` for success messages
6. Use `print_section` for section headers
7. Use bold formatting only when emphasis is needed
8. Use `MAIASS_VERBOSITY="debug"` instead of `MAIASS_DEBUG=true` for debugging
