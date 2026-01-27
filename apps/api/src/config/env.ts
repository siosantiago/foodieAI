import dotenv from "dotenv";

dotenv.config();

export const env = {
  nodeEnv: process.env.NODE_ENV ?? "development",
  port: Number(process.env.PORT ?? 4000),
  mongoUri: process.env.MONGODB_URI ?? "",
  llmProvider: process.env.LLM_PROVIDER ?? "mock",
  llmApiKey: process.env.LLM_API_KEY ?? "",
  transcriptionApiKey: process.env.TRANSCRIPTION_API_KEY ?? "",
  uberClientId: process.env.UBER_EATS_CLIENT_ID ?? "",
  uberClientSecret: process.env.UBER_EATS_CLIENT_SECRET ?? ""
};
