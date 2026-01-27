import { Recipe } from "../types/recipe";

export type LlmProvider = "mock";

export interface LlmClient {
  generateRecipeFromTranscript(transcript: string): Promise<Recipe>;
  answerCookingQuestion(params: {
    transcript: string;
    question: string;
    steps: string[];
  }): Promise<string>;
}

export class MockLlmClient implements LlmClient {
  async generateRecipeFromTranscript(transcript: string): Promise<Recipe> {
    const title = transcript.split(".")[0]?.slice(0, 60) || "Chef's Special";
    return {
      title: title.trim() || "Chef's Special",
      servings: 2,
      ingredients: [
        { name: "olive oil", quantity: "1 tbsp" },
        { name: "garlic", quantity: "2 cloves" },
        { name: "salt", quantity: "to taste" }
      ],
      steps: [
        { order: 1, instruction: "Prep ingredients and heat a pan." },
        { order: 2, instruction: "Cook aromatics and add main ingredients." },
        { order: 3, instruction: "Season and serve." }
      ],
      notes: ["Mock output - replace with real LLM provider."]
    };
  }

  async answerCookingQuestion(params: {
    transcript: string;
    question: string;
    steps: string[];
  }): Promise<string> {
    return `Based on the recipe, ${params.question} — keep heat moderate and taste as you go.`;
  }
}
