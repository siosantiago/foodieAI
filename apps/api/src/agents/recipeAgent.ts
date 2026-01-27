import { Recipe, validateRecipe } from "../types/recipe";
import { LlmClient, MockLlmClient } from "../services/llmClient";

export class RecipeAgent {
  private client: LlmClient;

  constructor(client?: LlmClient) {
    this.client = client ?? new MockLlmClient();
  }

  async createRecipe(transcript: string): Promise<Recipe> {
    const candidate = await this.client.generateRecipeFromTranscript(transcript);
    return validateRecipe(candidate);
  }

  async answerQuestion(params: {
    transcript: string;
    question: string;
    steps: string[];
  }): Promise<string> {
    return this.client.answerCookingQuestion(params);
  }
}
