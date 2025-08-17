# MAIASS Messaging System Improvements

This document summarizes the changes made to the MAIASS messaging system to address the following issues:

1. Confusion between verbosity levels and debug boolean
2. Implementation of print_always for verbosity-agnostic messages
3. Excessive use of bold formatting

## Changes Made

### 1. Clarified Relationship Between Verbosity and Debug

The relationship between `verbosity_level` and `debug_mode` has been clarified:

- `debug_mode` (controlled by `MAIASS_DEBUG`) is now deprecated in favor of using `MAIASS_VERBOSITY="debug"`
- For backward compatibility, setting `MAIASS_DEBUG=true` is treated the same as `MAIASS_VERBOSITY="debug"`
- Deprecation notices are logged when `debug_mode` is used
- An `effective_verbosity` variable is used to handle the logic consistently

This change makes it clear that there's a single system for controlling output verbosity, with `MAIASS_VERBOSITY` being the preferred method.

### 2. Fixed print_always Implementation

The `print_always` function has been fixed to properly accept parameters:

```bash
print_always(){
  local message="$1"
  echo -e "${Aqua}ℹ $message${Color_Off}"
  log_message "INFO: $message"
}
```

This function now correctly displays messages that are always shown regardless of the verbosity level.

### 3. Refined Use of Bold Formatting

The use of bold formatting has been refined:

- Added non-bold color variables for standard messages
- Updated print functions to use non-bold colors where appropriate:
  - `print_success`: Now uses non-bold Green
  - `print_warning`: Now uses non-bold Yellow
  - `print_section`: Now uses non-bold White/Yellow
  - `print_info`: Now uses non-bold Cyan for regular messages
- Kept bold formatting only where emphasis is needed:
  - `print_error`: Still uses bold Red for emphasis as errors are important
  - Debug-level messages in debug verbosity: Use bold Cyan to stand out

This change makes the output cleaner and more consistent, with bold formatting used only for emphasis.

## Backward Compatibility

All changes maintain backward compatibility:

- Scripts using `MAIASS_DEBUG=true` will continue to work
- Existing code that relies on the current behavior of print functions will continue to work
- No changes to the public API or command-line interface

## Future Development

For future development:

1. Use `MAIASS_VERBOSITY` instead of `MAIASS_DEBUG` for controlling output verbosity
2. Use `print_always` for messages that should always be shown
3. Use appropriate print functions with correct verbosity levels
4. Use bold formatting only when emphasis is needed
