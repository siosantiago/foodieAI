import { Collection, ObjectId } from "mongodb";
import { getDb } from "./mongo";
import { Ingredient, Step } from "../types/recipe";

export type TranscriptDoc = {
  _id?: ObjectId;
  videoUrl: string;
  transcript: string;
  source: "captions" | "transcription" | "mock";
  createdAt: Date;
};

export type RecipeDoc = {
  _id?: ObjectId;
  transcriptId: ObjectId;
  videoUrl: string;
  title: string;
  servings?: number;
  ingredients: Ingredient[];
  steps: Step[];
  notes?: string[];
  createdAt: Date;
};

export type CookSessionDoc = {
  _id?: ObjectId;
  recipeId: ObjectId;
  userId?: string;
  startedAt: Date;
};

export const transcriptsCollection = (): Collection<TranscriptDoc> =>
  getDb().collection<TranscriptDoc>("transcripts");

export const recipesCollection = (): Collection<RecipeDoc> =>
  getDb().collection<RecipeDoc>("recipes");

export const cookSessionsCollection = (): Collection<CookSessionDoc> =>
  getDb().collection<CookSessionDoc>("cook_sessions");
