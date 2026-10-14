# 📄 Technical Notes: CustomButton Component
* **Project:** CarStore
* **Component Path:** [lib\core\widgets\custom_button.dart](../../../lib/core/widgets/custom_button.dart)

---

## 🎯 Architectural Purpose
`CustomButton` is a reusable button used in the app.

It keeps the button style and behavior in one place.

---

## 🔑 Key Features
### 1. Loading State
- Uses `isLoading` to show a `CircularProgressIndicator`.
- The button is disabled while loading.
- This prevents multiple presses and duplicate requests.

### 2. Reusable Styling
- Uses `AppColors` and `AppStyles` as **Design Tokens**.
- This keeps colors, text style, shape, and elevation consistent.

### 3. Default Values
Uses **Null-Coalescing (`??`)** to give a default value when no custom value is provided.

Example:
```dart
backgroundColor ?? AppColors.primary
```

### 4. Encapsulation
`_buildButtonContent()` keeps the loading/label logic separate from the main `build()` method.

### 5. Flexible Size
- Default width: full available width.
- Default height: `48`.
- Custom sizes can be passed when needed.

---

## 🧠 Principles Used

- **SRP:** The widget handles the button UI and its common states.
- **DRY:** Common button code is written once.
- **Encapsulation:** Internal content logic is kept private.
---

## 🎤 Interview Points

**Why did you create `CustomButton`?**
> To keep the button style and common behavior in one reusable widget.

**Why `isLoading`?**
> To show the user that an operation is running and prevent multiple presses.

**Why `AppColors` and `AppStyles`?**
> They are Design Tokens. They keep the app style consistent and easy to change.

**Why `_buildButtonContent()`?**
> To keep the main `build()` method clean and make the content logic easier to read.
