---
name: Academic Pulse
colors:
  surface: '#f8f9ff'
  surface-dim: '#d0dbed'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e6eeff'
  surface-container-high: '#dee9fc'
  surface-container-highest: '#d9e3f6'
  on-surface: '#121c2a'
  on-surface-variant: '#3d4947'
  inverse-surface: '#27313f'
  inverse-on-surface: '#eaf1ff'
  outline: '#6d7a77'
  outline-variant: '#bcc9c6'
  surface-tint: '#006a61'
  primary: '#00685f'
  on-primary: '#ffffff'
  primary-container: '#008378'
  on-primary-container: '#f4fffc'
  inverse-primary: '#6bd8cb'
  secondary: '#4b41e1'
  on-secondary: '#ffffff'
  secondary-container: '#645efb'
  on-secondary-container: '#fffbff'
  tertiary: '#924628'
  on-tertiary: '#ffffff'
  tertiary-container: '#b05e3d'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#89f5e7'
  primary-fixed-dim: '#6bd8cb'
  on-primary-fixed: '#00201d'
  on-primary-fixed-variant: '#005049'
  secondary-fixed: '#e2dfff'
  secondary-fixed-dim: '#c3c0ff'
  on-secondary-fixed: '#0f0069'
  on-secondary-fixed-variant: '#3323cc'
  tertiary-fixed: '#ffdbce'
  tertiary-fixed-dim: '#ffb59a'
  on-tertiary-fixed: '#370e00'
  on-tertiary-fixed-variant: '#773215'
  background: '#f8f9ff'
  on-background: '#121c2a'
  surface-variant: '#d9e3f6'
  success-green: '#10b981'
  warning-amber: '#f59e0b'
  error-rose: '#f43f5e'
  surface-gray: '#f9fafb'
  border-subtle: '#e5e7eb'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  title-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  container-padding: 16px
  stack-gap: 12px
  section-gap: 24px
  touch-target: 44px
---

## Brand & Style

The design system is engineered for a high-utility academic environment. It balances a "Modern Corporate" aesthetic with "Minimalist" functionalism to ensure students can navigate complex information—grades, schedules, and financial data—without cognitive overload. 

The visual language is serious and trustworthy, evoking a sense of institutional reliability while maintaining a contemporary mobile-first feel. While the majority of the interface remains flat and high-contrast for maximum legibility, the design utilizes a specific Glassmorphism treatment for high-value personal artifacts (like the Digital Student ID) to provide a sense of depth and "physicality" to digital credentials.

## Colors

The palette is anchored by **Teal** as the primary brand color, representing growth and clarity. **Indigo** serves as the secondary color, used primarily for interactive elements and highlights to provide a professional, academic contrast.

- **Primary (Teal):** Used for primary actions, active navigation states, and brand headers.
- **Secondary (Indigo):** Used for text links, selection indicators, and secondary buttons.
- **Status Indicators:** Green (Success), Amber (Warning/Pending), and Rose (Critical/Error) are reserved strictly for semantic feedback and metric status.
- **Neutral:** A deep Charcoal (#1f2937) is used for primary text to ensure high contrast against white backgrounds, meeting WCAG AA accessibility standards.

## Typography

This design system utilizes **Inter** across all levels to ensure a systematic, utilitarian feel that excels in small-screen legibility. 

- **Hierarchy:** Strong weight differentiation is used to separate content. Headings use Semi-Bold (600) and Bold (700) weights with slightly tighter letter spacing for a compact, modern look.
- **Readability:** Body text defaults to 16px for primary content and 14px for supporting metadata to ensure the interface is accessible for all students.
- **Labels:** Small labels use a Bold weight and slight tracking (letter-spacing) to maintain legibility at 12px, specifically for status badges and overlines.

## Layout & Spacing

The layout follows a strict **8px grid system**. 

- **Mobile First:** The primary layout is a single-column fluid grid with 16px side margins. 
- **Rhythm:** Vertical spacing between related components (like cards in a list) is 12px, while spacing between major sections (like Academic Progress vs. Schedule) is 24px.
- **Safe Areas:** Bottom navigation and bottom sheets must respect the device's safe area insets to prevent overlap with hardware gestures.

## Elevation & Depth

The design system employs a **Flat-First** approach with depth used only for functional layering.

- **Level 0 (Base):** Background surface (#f9fafb).
- **Level 1 (Cards):** White surfaces with a 1px stroke (#e5e7eb) and no shadow for a clean, professional look.
- **Level 2 (Overlays):** Bottom sheets and menus use a soft, 15% opacity ambient shadow with a 12px blur to separate them from the base layer.
- **Special Case (Digital ID):** The Student ID card uses a **Glassmorphism** effect:
    - **Backdrop:** 20px blur.
    - **Surface:** White at 10% opacity.
    - **Border:** 1px white at 20% opacity.
    - **Contrast:** This creates a frosted "plastic" look that differentiates the ID from standard data cards.

## Shapes

The design system uses a consistent **8px (0.5rem)** radius for all standard UI components, including cards, input fields, and buttons. 

- **Standard (8px):** Metric cards, primary buttons, and input fields.
- **Large (16px):** Used for Bottom Sheets and the Digital ID card to provide a softer, more modern feel for high-interaction or focal elements.
- **Pill:** Reserved exclusively for status badges and chips to distinguish them from interactive buttons.

## Components

### Bottom Navigation Bar
A fixed container at the bottom of the screen. Active states use the Primary Teal color for the icon and a small 4px dot indicator underneath. Icons are 24px, accompanied by 10px labels.

### Bottom Sheets
Triggered for filters or detailed task views. They feature a 4px wide "grabber" bar at the top center and 16px top-corner rounding.

### Metric Cards
White background, 8px radius, 1px subtle border. These display a label (top-left), a large value (center), and a status badge (bottom-right).

### Status Badges
Small, pill-shaped indicators.
- **Success:** Light green background with dark green text.
- **Pending:** Light amber background with dark amber text.
- **Alert:** Light rose background with dark rose text.

### Buttons
- **Primary:** Solid Teal background with White text. 8px radius.
- **Secondary:** White background with Indigo border and text. 8px radius.

### Input Fields
1px Charcoal border (20% opacity). On focus, the border thickens to 2px and changes to Primary Teal. Labels are always visible above the field.