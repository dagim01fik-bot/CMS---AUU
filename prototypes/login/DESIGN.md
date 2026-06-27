---
name: Secure Access Portal
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#45464d'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#76777d'
  outline-variant: '#c6c6cd'
  surface-tint: '#565e74'
  primary: '#000000'
  on-primary: '#ffffff'
  primary-container: '#131b2e'
  on-primary-container: '#7c839b'
  inverse-primary: '#bec6e0'
  secondary: '#4b41e1'
  on-secondary: '#ffffff'
  secondary-container: '#645efb'
  on-secondary-container: '#fffbff'
  tertiary: '#000000'
  on-tertiary: '#ffffff'
  tertiary-container: '#001e2f'
  on-tertiary-container: '#008cc7'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dae2fd'
  primary-fixed-dim: '#bec6e0'
  on-primary-fixed: '#131b2e'
  on-primary-fixed-variant: '#3f465c'
  secondary-fixed: '#e2dfff'
  secondary-fixed-dim: '#c3c0ff'
  on-secondary-fixed: '#0f0069'
  on-secondary-fixed-variant: '#3323cc'
  tertiary-fixed: '#c9e6ff'
  tertiary-fixed-dim: '#89ceff'
  on-tertiary-fixed: '#001e2f'
  on-tertiary-fixed-variant: '#004c6e'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  display:
    fontFamily: Hanken Grotesk
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Hanken Grotesk
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Hanken Grotesk
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  headline-md:
    fontFamily: Hanken Grotesk
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-lg:
    fontFamily: Hanken Grotesk
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Hanken Grotesk
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Geist
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.02em
  code:
    fontFamily: Geist
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 18px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 40px
  2xl: 64px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: auto
  max-width-auth: 440px
---

## Brand & Style

The design system is engineered for high-stakes enterprise environments where security, trust, and clarity are paramount. The brand personality is authoritative yet frictionless, evoking a sense of "impenetrable transparency." It utilizes a **Corporate Modern** foundation infused with **Glassmorphism** accents to signify a premium, cutting-edge technical stack.

The target audience consists of IT administrators and enterprise employees who require a high-efficiency, low-cognitive-load authentication experience. The UI prioritizes a calm, focused environment to reduce user anxiety during security-critical tasks like multi-factor authentication and password recovery.

- **Minimalist Layouts:** Concentrated focus on primary tasks.
- **Glassmorphism:** Used selectively on interactive overlays and cards to create visual depth without sacrificing performance.
- **High-Contrast:** Explicitly designed to exceed WCAG 2.1 AA standards for accessibility.

## Colors

The color strategy uses a deep, "Midnight" palette to anchor the interface in a sense of stability. 

- **Primary (Deep Blue):** Used for navigation, headers, and core brand moments. It provides a serious, professional grounding.
- **Secondary (Indigo):** Reserved for primary actions (CTAs), focus states, and progress indicators. It provides a vibrant, modern contrast to the deep primary.
- **Neutral (Slate Gray):** A scale of grays used for typography, borders, and secondary backgrounds to ensure a soft, non-stark reading experience.
- **Functional Colors:** Success Green and Error Red are highly saturated to ensure they are immediately distinguishable against the neutral background.

## Typography

This design system utilizes **Hanken Grotesk** for its primary communication due to its sharp, contemporary geometry and exceptional legibility at various weights. It strikes the perfect balance between a friendly tech startup and a rigorous enterprise firm.

**Geist** is employed for labels, data points, and technical metadata. Its monospaced-influenced proportions provide a technical "developer-friendly" feel that reinforces the security context of the portal.

- **Weight Usage:** Use SemiBold (600) for headlines to ensure hierarchy. Use Medium (500) for labels to maintain legibility against colored backgrounds.
- **Scale:** High contrast between Display and Body sizes is encouraged to create a clear "Information First" hierarchy.

## Layout & Spacing

The layout philosophy follows a **Fixed-Fluid Hybrid** model. Authentication flows (Login, MFA, Recovery) are contained within a fixed-width central container (440px) to minimize eye-travel and increase focus. Dashboard and administrative views utilize a 12-column fluid grid.

- **Spacing Rhythm:** Based on a 4px baseline grid. All padding and margins must be increments of 4px.
- **Horizontal Alignment:** Content should be centered on the X-axis for mobile and desktop login screens.
- **Breakpoints:** 
  - Mobile: < 640px (1 column, 16px margins)
  - Tablet: 640px - 1024px (8 columns, 24px margins)
  - Desktop: > 1024px (12 columns, 24px gutters)

## Elevation & Depth

This design system uses a combination of **Ambient Shadows** and **Glassmorphism** to communicate hierarchy.

- **Surface 0 (Background):** Solid `#F8FAFC`. No elevation.
- **Surface 1 (Cards):** White background with a soft, multi-layered shadow: `0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)`.
- **Surface 2 (Glass Accents):** Used for "Verification Pending" states or floating headers. Background: `rgba(255, 255, 255, 0.7)`, Backdrop Blur: `12px`, Border: `1px solid rgba(255, 255, 255, 0.3)`.
- **Interactive States:** On hover, buttons and cards should slightly increase their shadow spread and lift (Y-axis -2px) to provide tactile feedback.

## Shapes

The shape language is defined by a consistent **16px (1rem)** radius, which provides a premium, modern feel that softens the "cold" nature of security software.

- **Primary Radius:** 16px for cards, input fields, and large buttons.
- **Small Radius:** 8px for smaller UI elements like chips, checkboxes, and tooltips.
- **Interactive Elements:** Maintain the 16px radius for primary CTAs to ensure they feel substantial and easy to tap on mobile devices.

## Components

### Buttons
- **Primary:** Solid Indigo background, White text, 16px height-padding.
- **Secondary:** Transparent background, Deep Blue border (1px), Deep Blue text.
- **Ghost:** No border, Indigo text, subtle gray background on hover.

### Input Fields
- **Default State:** White background, 1px Gray-200 border, 16px rounded corners.
- **Focus State:** 2px Indigo border with a 4px soft Indigo outer glow (box-shadow).
- **Labeling:** Use Geist Medium for labels, placed above the field.

### Cards
- Standard auth cards should have 32px or 40px internal padding to provide "breathing room."
- Borders should be a very faint `1px solid #E2E8F0` to define the edges in high-light environments.

### Feedback Indicators
- **Success:** Green-600 icons with light green tinted backgrounds for alerts.
- **Error:** Red-600 icons and text. Use high-contrast red for error messages to ensure they are legible.

### MFA Tiles
- Large, 16px rounded tiles for selecting authentication methods (Push, SMS, Hardware Key).
- Use subtle animations (0.2s ease-in-out) when hovering over these tiles to reinforce the premium feel.