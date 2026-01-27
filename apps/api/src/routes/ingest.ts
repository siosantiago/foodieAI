import { Router } from "express";
import { ingestVideo } from "../services/videoIngest";

export const ingestRouter = Router();

ingestRouter.post("/", async (req, res, next) => {
  try {
    const { videoUrl } = req.body as { videoUrl?: string };
    if (!videoUrl) {
      return res.status(400).json({ error: "videoUrl is required" });
    }
    const result = await ingestVideo(videoUrl);
    return res.json(result);
  } catch (error) {
    return next(error);
  }
});
