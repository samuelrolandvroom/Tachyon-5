# 🎨 Tachyon-5 Brand Strategy

## Mission & Vision

**Mission**: Empower users to capture, organize, and synchronize their thoughts, tasks, and reminders across all devices with confidence and ease.

**Vision**: Become the trusted, intelligent companion for managing information that matters—fast, secure, and always available.

**Brand Personality**: Logical, efficient, bold, and accessible. Like a trusted AI character (Data, Odo), the app "just knows" what you need.

---

## 1. Visual Identity & Tone: "Logical Velocity"

The brand should feel **pre-computed**—like the app doesn't think, it just knows. The UI should feel like a high-end tactical console that is surprisingly easy to use.

### Core Attributes
- **Precision**: Every pixel has purpose
- **Velocity**: Fast, responsive interactions
- **Intelligence**: Anticipatory design that adapts to user behavior
- **Accessibility**: Beautiful AND functional for all users
- **Trustworthiness**: Enterprise-grade security with consumer-friendly UX

---

## 2. The 2026 "Atlantis" Color Palette

A modern, sci-fi-inspired palette optimized for Dark Mode with high accessibility contrast ratios.

### Primary Colors

| Role | Color Name | Hex Code | RGB | WCAG Contrast | Purpose |
|------|-----------|----------|-----|---------------|---------|
| Primary | Atlantis Blue | `#00D4FF` | (0, 212, 255) | 11.5:1 | Action buttons, Speed lines, Active states |
| Secondary | Event Horizon | `#0A192F` | (10, 25, 47) | N/A (bg) | Main background (Dark mode) |
| Accent | Zero-Point Amber | `#FFB800` | (255, 184, 0) | 7.2:1 | Reminders, Alerts, High-priority tasks |
| Neutral | Lantean Silver | `#E2E8F0` | (226, 232, 240) | 14.8:1 | Primary Text, Markdown headers |
| Security | Shield Violet | `#6D28D9` | (109, 40, 217) | 6.1:1 | Encryption indicators, Secure sync status |

### Status Colors

| State | Hex Code | RGB | Usage |
|-------|----------|-----|-------|
| Success | `#10B981` | (16, 185, 129) | Completed tasks, Successful sync |
| Warning | `#F59E0B` | (245, 158, 11) | Draft, Unsaved changes |
| Error | `#EF4444` | (239, 68, 68) | Sync failed, Validation errors |
| Info | `#3B82F6` | (59, 130, 246) | Tips, Notifications, Help text |

### Semantic Color Usage

- **Actions**: Atlantis Blue (all CTAs, hover states)
- **Backgrounds**: Event Horizon (primary surface), slightly lighter variants for depth
- **Alerts & Urgency**: Zero-Point Amber + Error Red
- **Borders & Dividers**: 15% opacity Lantean Silver
- **Text**: Lantean Silver (primary), 60% opacity for secondary
- **Interactive Elements**: Highlight with Shield Violet on hover/focus

---

## 3. Typography

### Font Families

- **Headings (H1–H4)**: 
  - Primary: **Michroma** (Google Fonts) — Geometric, modern, sci-fi feel
  - Fallback: System font stack (Segoe UI, Helvetica Neue)
  
- **Body & UI Text**: 
  - Primary: **Inter** (Google Fonts) — Clean, readable, accessible
  - Fallback: System stack
  
- **Code & Technical**: 
  - **JetBrains Mono** (Google Fonts) — Monospaced, developer-friendly, distinctive
  
- **Markdown Content**:
  - Use system fonts for compatibility; apply custom styling via CSS/theme overrides

### Type Scale

| Element | Size | Weight | Line Height | Letter Spacing |
|---------|------|--------|-------------|----------------|
| H1 (Page Title) | 32px | 700 | 1.2 | -0.5px |
| H2 (Section) | 24px | 600 | 1.3 | 0px |
| H3 (Subsection) | 20px | 600 | 1.35 | 0px |
| H4 (Subheading) | 16px | 600 | 1.4 | 0px |
| Body | 14px | 400 | 1.6 | 0.3px |
| Caption | 12px | 400 | 1.5 | 0.2px |
| Code (inline) | 13px | 400 | 1.5 | 0px |
| Code (block) | 12px | 400 | 1.6 | 0px |

---

## 4. Logo & Branding Assets

### Logo Specification

**File**: `logo.png` (included in docs folder)

### Logo Usage Guidelines

- **Minimum Size**: 40px (digital), 15mm (print)
- **Spacing**: Maintain at least 1x the "T" height clear space around logo
- **Colors**:
  - Full color: Use Atlantis Blue + Lantean Silver
  - Monochrome (dark): Full black on light backgrounds
  - Monochrome (light): Full white on dark backgrounds
- **Background**: Transparent recommended; minimum contrast ratio 4.5:1

### Logomark Variations

1. **Full Logo**: Icon + "Tachyon-5" wordmark (horizontal)
2. **Icon Only**: Standalone symbol (for favicons, app icons)
3. **Stacked**: Icon above wordmark (for narrow spaces)
4. **Do Not Distort**: Never skew, rotate >5°, or apply effects without approval

---

## 5. UI Components & Interaction Design

### Button Styles

- **Primary CTA**: Solid Atlantis Blue, 4px border-radius, 12px padding
- **Secondary**: Outline with Atlantis Blue stroke, transparent fill
- **Danger**: Solid Error Red (only for destructive actions)
- **Disabled**: 30% opacity + cursor-not-allowed

### Cards & Surfaces

- **Surface Elevation**: Use subtle box-shadow or 5% opacity Lantean Silver border
- **Border Radius**: Consistent 8px (modern, approachable)
- **Spacing**: 16px padding (mobile), 24px (desktop)

### Input Fields

- **Border**: 1px Lantean Silver, 4px radius
- **Focus State**: 2px Atlantis Blue border, subtle glow
- **Placeholder**: 60% opacity text
- **Error State**: 1px solid Error Red

### Navigation

- **Current Page Indicator**: Atlantis Blue accent underline or highlight
- **Hover State**: 5% opacity overlay (Atlantis Blue or Lantean Silver)
- **Mobile**: Bottom navigation with 3–5 primary destinations

---

## 6. Motion & Micro-interactions

### Animation Principles

- **Duration**: 200–400ms for UI transitions (feel snappy, not sluggish)
- **Easing**: Use ease-in-out for natural motion
- **Accessibility**: Respect `prefers-reduced-motion` media query

### Common Interactions

| Action | Duration | Easing | Feedback |
|--------|----------|--------|----------|
| Button press | 150ms | ease-out | Color shift + subtle scale (0.98) |
| List transition | 300ms | ease-in-out | Fade + slide up |
| Modal open | 250ms | ease-out | Scale from center + fade |
| Notification | 300ms | ease-out | Slide in from top + sound (opt-in) |
| Sync indicator | Continuous | linear | Rotating spinner (Atlantis Blue) |

---

## 7. Tone of Voice

### Writing Principles

- **Be Direct**: "Create a task" not "Would you like to create a task?"
- **Be Helpful**: Provide context in error messages; suggest solutions
- **Be Honest**: Show sync status transparently; admit when features are offline
- **Be Concise**: Short sentences, active voice, avoid jargon

### Example Copy

- **Empty State**: "No tasks yet. Create one to get started!" (not "Your task list is empty")
- **Error**: "Can't sync right now. We'll try again when you're online." (not "Error 503")
- **Success**: "All synced!" (not "Synchronization completed successfully")

---

## 8. Photography & Imagery

### Style

- **Tone**: Clean, modern, minimal. Focus on clarity and purpose.
- **Color**: Leverage the Atlantis palette as accent overlays on neutral photography
- **Subjects**: 
  - UI mockups with gradient overlays
  - Workspace/productivity scenarios
  - Diversity in all imagery

### Usage

- Hero images on landing pages
- In-app onboarding screens
- Marketing materials (website, social)
- Social proof (user testimonials with authentic photos)

---

## 9. Icons

### Icon Style

- **Stroke Width**: 1.5–2px (balance between thin and heavy)
- **Rounded Corners**: 2–3px (approachable, modern)
- **Size Grid**: 16px, 24px, 32px, 48px (scale proportionally)
- **Color**: Inherit from text color context or use Atlantis Blue for active/interactive states

### Icon Sources

- **Primary**: Custom set (designed in Figma, exported as SVG)
- **Fallback**: Google Material Icons (size 24) or Feather Icons

---

## 10. Brand Applications

### Web Platform

- **Header**: Logo + navigation (Responsive design, hamburger menu on mobile)
- **Footer**: Links, social icons (Shield Violet accent), copyright
- **Dark Mode**: Default experience; light mode available as opt-in

### Mobile App (Flutter)

- **Status Bar**: Event Horizon background
- **App Icon**: Logomark at 192px (launcher), 180px (iOS)
- **Splash Screen**: Centered logo on Event Horizon gradient (2–3 sec duration)

### Desktop App (Windows/macOS)

- **Window Chrome**: Minimize, maximize, close buttons styled with Atlantis Blue highlights
- **Taskbar Icon**: Logomark (256px source, OS will scale)

### Documentation & Internal Tools

- **README Badges**: Tachyon-5 branding in project headers
- **Code Comments**: Occasional brand personality in onboarding/help text
- **Error Pages**: Helpful, on-brand messaging (not generic 404s)

---

## 11. Accessibility Commitments

- **WCAG 2.1 Level AA Minimum**: All colors meet contrast requirements
- **Keyboard Navigation**: All interactive elements accessible via Tab/Enter
- **Screen Readers**: Semantic HTML, ARIA labels for custom components
- **Motion**: Animations respect `prefers-reduced-motion` preference
- **Font Sizing**: No text smaller than 12px; allow user zoom to 200%
- **Color Alone**: Never use color as the only way to convey information

---

## 12. Brand DO's & DON'Ts

### DO ✅

- Use the full color palette for visual richness
- Maintain consistent spacing (8px grid)
- Test contrast ratios before shipping
- Celebrate user milestones (completion, streak, sync success)
- Keep loading states visible and honest

### DON'T ❌

- Use gradients on text (readability issue)
- Mix serif and sans-serif arbitrarily
- Hide error states or sync failures
- Use animations to distract from missing functionality
- Assume dark mode; always test both light and dark

---

## 13. Design Review Checklist

Before launch, verify:

- [ ] All text meets WCAG AA contrast (4.5:1 minimum)
- [ ] Color palette consistent across all platforms
- [ ] Button sizes >= 44px (mobile touch target)
- [ ] Animations respect `prefers-reduced-motion`
- [ ] Logo usage complies with spacing guidelines
- [ ] Keyboard navigation works on all screens
- [ ] Copy is concise and helpful
- [ ] Icons are consistent in style and weight
- [ ] Spacing follows 8px grid
- [ ] Focus states are visible (2px outline minimum)

---

## 14. Future Enhancements

- **White-label Support**: Allow enterprise customers to rebrand colors/logo
- **Light Mode**: Secondary theme (currently lower priority)
- **Animations Library**: Shareable component animations across web + app
- **Brand Kit Export**: Figma → code (CSS variables, Dart constants)
- **Social Media Templates**: Pre-designed Tachyon-5 branded assets for sharing

---

## 15. Resources & References

- **Design Tool**: Figma (shared with team)
- **Color Tool**: [Coolors.co](https://coolors.co) for palette exploration
- **Font CDN**: Google Fonts (Michroma, Inter, JetBrains Mono)
- **Icon Library**: Feather Icons (fallback), custom SVGs (primary)
- **Documentation**: This file + linked Figma design system

---

**Last Updated**: January 11, 2026  
**Version**: 1.0  
**Maintainer**: Design Team
