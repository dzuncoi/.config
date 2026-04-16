# Plan-Before-Code Workflow

**Extracted:** 2026-02-05
**Context:** Multi-step implementations, refactoring, bug fixes, feature additions

## Problem

Claude frequently jumps straight into writing code or making changes without confirming the approach, leading to:
- Wasted effort on wrong approaches
- Rejected actions and user frustration
- Implementation that doesn't match user intent
- Scope drift in large sessions

**Root Cause Pattern:** When given a task, Claude defaults to immediate implementation rather than planning and getting approval first.

## Solution

A structured three-phase workflow that enforces planning before action:

### Phase 1: Analysis & Planning
1. **Read** all relevant files first (don't assume what's there)
2. **Create** a TodoWrite task list with numbered phases
3. **Define** concrete validation steps for each phase (e.g., `npm run build` passes, specific test passes, `tsc --noEmit` clean)
4. **STOP** - Present the plan and wait for approval

### Phase 2: Phased Implementation
For each approved phase:
1. Make the changes (minimal scope, only what's needed for this phase)
2. Run the validation step defined in planning
3. If validation fails, fix iteratively until it passes
4. Summarize what changed and what was validated
5. Only then move to next phase

### Phase 3: Final Verification
- Run full test suite if applicable
- Check for unintended side effects
- Verify all phases completed successfully

## Example

**User Request:** "Implement dark mode support"

**Bad Approach (No Planning):**
```
Claude: Let me add dark mode support...
[Immediately starts editing multiple files]
[User has to interrupt and redirect]
```

**Good Approach (Plan-Before-Code):**
```
Claude: Let me analyze the codebase and create a plan first.

[Reads theme files, component structure, existing patterns]

Here's my implementation plan using TodoWrite:

Phase 1: Theme Infrastructure (Validation: tsc --noEmit passes)
- Add dark mode types to theme.ts
- Create theme context provider
- Add theme toggle hook

Phase 2: Component Updates (Validation: npm run build passes)
- Update 5 core components to use theme context
- Replace hardcoded colors with theme variables

Phase 3: Persistence (Validation: manual test of theme persistence)
- Add localStorage integration
- Test theme persistence across sessions

STOP - Does this plan look good? Any phases to add/remove/reorder?

[Waits for user approval before writing any code]
```

## When to Use

**ALWAYS use this workflow when:**
- Task involves 3+ steps or multiple files
- User has previously asked you to "discuss first" or "show the plan"
- The task has multiple valid approaches (refactoring, architecture decisions)
- You're making changes to complex features (state management, data flow)
- The task could impact existing functionality

**Skip this workflow ONLY when:**
- Single trivial fix (typo, obvious syntax error)
- User has given extremely detailed, step-by-step instructions
- Pure research/exploration (no code changes)

## Integration with CLAUDE.md

This pattern is codified in the user's CLAUDE.md rules:
> "Always discuss your plan and show findings BEFORE making any code changes. Write down your audit/analysis first, get approval, then implement."

## Success Metrics

When this pattern is followed correctly:
- ✅ User approves plan before any code is written
- ✅ Each phase's validation step catches issues early
- ✅ No rejected actions due to wrong approach
- ✅ Clear visibility into progress via TodoWrite
- ✅ Easy to course-correct between phases

## Anti-Patterns to Avoid

❌ Creating the todo list but immediately starting Phase 1 without approval
❌ Asking "Should I proceed?" verbally instead of using TodoWrite structure
❌ Defining phases without concrete validation steps
❌ Skipping validation steps when "things seem to work"
❌ Continuing to next phase after validation failure
