# Contributing to ZSH Configuration

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing.

## Code of Conduct

Be respectful and constructive in all interactions. We're all here to help!

## Getting Started

1. **Fork the repository**
   ```bash
   # Click "Fork" on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/yourusername/zsh-config.git
   cd zsh-config
   ```

3. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes**
   - Follow the existing code style
   - Add comments for complex logic
   - Test thoroughly

5. **Commit with clear messages**
   ```bash
   git commit -m "Add feature: brief description"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Open a Pull Request**
   - Provide a clear title and description
   - Reference any related issues
   - Explain why this change is needed

## Development Guidelines

### Code Style

#### ZSH Code
```bash
# Use descriptive names
function do_something_useful() {
    # Add comment explaining what this does
    local input="$1"

    # Early exit with error handling
    [[ -z "$input" ]] && { echo "Error: input required"; return 1; }

    # Do work
    echo "Processing: $input"
}

# Aliases should be short and intuitive
alias myalias='command --flag'
```

#### Documentation
- Document all public functions
- Include usage examples
- Explain complex logic
- Add comments for non-obvious code

### File Organization

- **aliases.zsh** - Add aliases grouped by category (Docker, K8s, Python, etc.)
- **functions.zsh** - Add utility functions with full documentation
- **go.zsh** - Add Go-specific tools and functions
- **user-aliases.zsh** - Leave for user customization

### Testing

Before submitting a PR, test your changes:

```bash
# Reload shell
exec zsh

# Test new aliases
myalias --help

# Test new functions
my_function arg1 arg2

# Check for startup errors
zsh -i -c exit

# Verify no broken references
grep -r "myfunction" ~/.config/zsh/*.zsh
```

## Types of Contributions

### 🐛 Bug Fixes
- Describe the bug clearly
- Include steps to reproduce
- Explain your fix
- Test thoroughly

### ✨ New Features
- Propose the feature in an issue first
- Keep scope focused
- Add documentation
- Include examples

### 📚 Documentation
- Fix typos and unclear sections
- Add examples
- Improve organization
- Update outdated information

### 🎨 Improvements
- Performance optimizations
- Code cleanup
- Better organization
- Enhanced user experience

## Pull Request Process

1. **Update Documentation**
   - README.md if user-facing
   - CHANGELOG.md if notable change
   - Inline comments in code

2. **Test Your Changes**
   ```bash
   # New shell startup
   exec zsh

   # Test aliased commands
   d ps          # if added docker alias
   go-fmt        # if added go function

   # Verify no regressions
   # Test existing features still work
   ```

3. **Keep Commits Clean**
   - One feature per commit
   - Meaningful commit messages
   - No merge commits (rebase if needed)

4. **Follow PR Template**
   ```markdown
   ## Description
   Brief description of changes

   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Documentation update
   - [ ] Performance improvement

   ## Testing
   How did you test this?

   ## Checklist
   - [ ] Code follows style guidelines
   - [ ] Self-review completed
   - [ ] Comments added for complex logic
   - [ ] Documentation updated
   - [ ] No new warnings generated
   ```

## Common Contribution Types

### Adding a New Alias

1. Add to appropriate section in `aliases.zsh`:
```bash
# ============================================================================
# MY_CATEGORY
# ============================================================================
alias myalias='command --flag'                           # Brief description
```

2. Update README.md with the new alias
3. Test: `myalias --help`

### Adding a New Function

1. Add to `functions.zsh` with full documentation:
```bash
# Function description
# Usage: my_function [args]
# Example: my_function "input"
function my_function() {
    local arg="$1"
    [[ -z "$arg" ]] && { echo "Error: argument required"; return 1; }

    # Implementation
    echo "Result: $arg"
}
```

2. Add tests in your PR description
3. Update CHANGELOG.md if it's a significant addition

### Adding a Go Tool

1. Add to `go.zsh` following existing patterns
2. Include error handling
3. Add to README.md usage examples
4. Test with a real Go project

### Reporting a Bug

Use GitHub Issues with this template:
```
### Description
Brief description of the bug

### Steps to Reproduce
1. Do this
2. Then this
3. Bug occurs

### Expected Behavior
What should happen

### Actual Behavior
What actually happens

### Environment
- macOS/Linux version
- ZSH version: `zsh --version`
- Shell startup time: `time zsh -i -c exit`

### Error Messages
Any error output (if applicable)
```

## Style Guide

### Naming Conventions
- **Functions**: `descriptive_function_name()`
- **Aliases**: `short` (d for docker, k for kubectl)
- **Variables**: `local_variable_name`
- **Constants**: `CONSTANT_NAME`

### Comments
```bash
# Single line comment for simple code
function simple_task() {
    echo "Doing something"
}

# Multi-line comments for complex logic
function complex_task() {
    # This part does X by iterating through Y
    # and checking for Z conditions
    for item in "${items[@]}"; do
        [[ "$item" =~ pattern ]] && process_item
    done
}
```

### Error Handling
```bash
# Good: Check early, exit early
function robust_function() {
    local required="$1"
    [[ -z "$required" ]] && { echo "Error: arg required"; return 1; }

    local optional="$2"
    [[ -z "$optional" ]] && optional="default"

    # Do work
}
```

## Performance Considerations

- Avoid heavy operations in startup path
- Use lazy-loading when appropriate
- Cache when possible
- Test startup time: `time zsh -i -c exit`

## Questions?

- Open a GitHub Discussion
- Check existing PRs and issues
- Review CHANGELOG.md for context
- Ask in comments on related issues

## Recognition

Contributors will be acknowledged in:
- CONTRIBUTORS.md (to be created)
- GitHub contributors page
- Release notes (for significant contributions)

---

Thank you for making this project better! 🎉
