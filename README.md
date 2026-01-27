# FoodieAI

MVP app that turns cooking videos into structured recipes, grocery lists, and a cooking assistant, plus an Uber Eats ordering stub.

## Stack
- Backend + AI agent: TypeScript/Node
- Database: MongoDB
- iOS app: Swift/SwiftUI

## Backend setup
1. Install dependencies:
   - `npm install`
2. Create environment file:
   - `cp .env.example .env` and fill values
3. Start API:
   - `npm run dev`

API runs on `http://localhost:4000`.

### Endpoints
- `POST /api/ingest` `{ "videoUrl": "..." }`
- `POST /api/recipes` `{ "transcriptId": "...", "videoUrl": "..." }`
- `GET /api/recipes/grocery-list/:recipeId`
- `POST /api/cook/session` `{ "recipeId": "...", "userId": "..." }`
- `POST /api/cook/qna` `{ "sessionId": "...", "question": "..." }`
- `POST /api/order/ubereats` `{ "recipeId": "...", "userLocation": "..." }`

## iOS app
Open `ios/foodieAIApp/foodieAIApp.xcodeproj` in Xcode.
Update `APIClient.baseURL` if running on a device.
