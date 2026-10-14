# 📄 Technical Note: CustomTextField Widget

- 🔗 **Diagram File:** [custom_text_field.mmd](custom_text_field.mmd)
- 🛠️ **Source Code:** [custom_text_field.dart](../../../lib/core/widgets/custom_text_field.dart)

---

## 🎯 Overview

Reusable text form field designed to unify input decorations across the Auth feature (Login, SignUp) and other forms.

## 🏛️ Applied Principles

- **SRP (Single Responsibility):** Manages only user text input rendering and decoration state.
- **DRY (Don't Repeat Yourself):** Eliminates 30+ lines of duplicate `InputDecoration` border code in views.

## ⚙️ Key Technical Points

1. **Focus State Handling:** Uses `focusedBorder` with primary orange color (`AppColors.primary`).
2. **Null-Safety Shield:** `prefixIcon` and `controller` are nullable to support optional icons and flexible controllers.
3. **UX Optimization:** Uses `labelText` instead of `hintText` to maintain floating context while typing.
