import express from "express";
import cors from "cors";
import { env } from "./config/env";
import { connectMongo } from "./db/mongo";
import { apiRouter } from "./routes";
import { errorHandler } from "./middleware/errorHandler";

const app = express();

app.use(cors());
app.use(express.json({ limit: "2mb" }));

app.get("/health", (_req, res) => {
  res.json({ ok: true, env: env.nodeEnv });
});

app.use("/api", apiRouter);

app.use(errorHandler);

const start = async () => {
  await connectMongo();
  app.listen(env.port, () => {
    // eslint-disable-next-line no-console
    console.log(`API listening on :${env.port}`);
  });
};

start().catch((error) => {
  // eslint-disable-next-line no-console
  console.error("Failed to start API", error);
  process.exit(1);
});
