# iOS Frontend Changes

Summary of current changes on the FoodieAI iOS app (SwiftUI).

---

## New Files

### `BuyIngredientsCTA.swift`
- Call-to-action button: **"Buy Ingredients"** that builds shopping links from a list of ingredient strings.
- Uses `AppState.buildIngredientLinks(from:)` and navigates to `IngredientLinksView` when done.
- Styled with `BrandFont` and `primaryButtonStyle()`; disabled when `ingredients` is empty.

### `IngredientLinksView.swift`
- Screen titled **"Buy Ingredients"** with subtitle *"Curated links from top retailers"*.
- States: loading (progress + "Finding the best links…"), empty (cart icon + copy), or list of retailer links.
- Each link is a row (arrow icon + title) opening in a `SafariView` sheet.
- Uses `ThemedContainer`, `BrandColor`, `BrandFont`, and dark background.

### `DesignSystem.swift`
- **BrandColor**: `primary`, `primaryGradientStart`/`End`, `background`, `card`, `separator`, `subtle`.
- **BrandFont**: `largeTitle`, `title`, `headline`, `body`, `caption` (rounded system font helpers).
- **CardStyle**: modifier for padded card with rounded rect, border, shadow.
- **primaryButtonStyle()**: full-width gradient primary button with rounded corners and shadow.
- **AppBackground**: modifier that wraps content in `BrandColor.background`.

### `ShoppingLinkBuilder.swift`
- Builds `[IngredientLink]` from `[String]` (ingredient names) with no network calls.
- Produces search URLs for: **Google Shopping**, **Amazon**, **Walmart**, **Instacart**, **Target**, **Costco**.
- Trims/empties input and encodes a single comma-separated query for all links.

### `ThemedContainer.swift`
- Reusable layout: top bar (title + optional subtitle), then content inside a card-style block.
- Applies `appBackground()`, `cardStyle()`, and toolbar styling (dark nav bar).
- Used by Buy Ingredients flow, Order/Shop Ingredients, and previews.

---

## Modified Files

### `AppState.swift`
- **New model**: `IngredientLink` (id, title, url) — `Identifiable`, `Hashable`.
- **New state**: `ingredientLinks: [IngredientLink]`, `isBuildingIngredientLinks: Bool`.
- **New method**: `buildIngredientLinks(from ingredients: [String]) async` — sets loading flag, calls `ShoppingLinkBuilder.buildLinks(for:)`, assigns `ingredientLinks`.

### `OrderView.swift`
- Rebuilt as **"Shop Ingredients"** with subtitle *"Individual items from top retailers"*.
- Uses `ThemedContainer`; empty state shows icon and copy when no recipe/ingredients.
- **Ingredient grid**: `LazyVGrid` of `IngredientOrderCard` per ingredient.
- **IngredientOrderCard**: Unsplash-based image, quantity badge, ingredient name, **"Buy Now"** menu with retailer links (same builders as `ShoppingLinkBuilder`); selecting a link opens `SafariView` in a sheet.
- **SafariView**: `UIViewControllerRepresentable` around `SFSafariViewController` for in-app browsing.

### `project.pbxproj`
- New source files added to the app target so the project builds with the new views and models.

---

## Flow

1. User gets a recipe (video → recipe) and sees ingredients in Recipe / Grocery / Order.
2. **Order** tab shows a grid of ingredients; each card has **"Buy Now"** with links to Google Shopping, Amazon, Walmart, Instacart, Target, Costco.
3. **Buy Ingredients** CTA (where used) builds links for the full list and pushes to **IngredientLinksView**, where the user picks a retailer and opens it in Safari.

All shopping links are generated client-side via `ShoppingLinkBuilder`; no backend calls for link building.
