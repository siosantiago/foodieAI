import { Router } from "express";
import { startCookSession, answerCookQuestion } from "../services/cookService";

export const cookRouter = Router();

cookRouter.post("/session", async (req, res, next) => {
  try {
    const { recipeId, userId } = req.body as { recipeId?: string; userId?: string };
    if (!recipeId) {
      return res.status(400).json({ error: "recipeId is required" });
    }
    const session = await startCookSession(recipeId, userId);
    return res.json(session);
  } catch (error) {
    return next(error);
  }
});

cookRouter.post("/qna", async (req, res, next) => {
  try {
    const { sessionId, question } = req.body as {
      sessionId?: string;
      question?: string;
    };
    if (!sessionId || !question) {
      return res.status(400).json({ error: "sessionId and question are required" });
    }
    const answer = await answerCookQuestion(sessionId, question);
    return res.json(answer);
  } catch (error) {
    return next(error);
  }
});
