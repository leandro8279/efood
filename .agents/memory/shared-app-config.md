---
name: Shared app configuration
description: User-stated scope for the domain Config model and guidance for sharing it across screens.
---

The user says the domain `Config` model is consumed by multiple screens.

**Why:** The user stated that the configuration is used across several screens.

**How to apply:** Keep one shared source of truth for `Config` in the data layer. Cache successful reads there rather than duplicating state in view models. Expose reactive updates only if configuration can change during an active session and screens must respond immediately.
