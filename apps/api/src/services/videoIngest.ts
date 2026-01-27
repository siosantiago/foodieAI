import { ObjectId } from "mongodb";
import { transcriptsCollection } from "../db/collections";

const mockTranscriptFromUrl = (videoUrl: string) =>
  `Transcript for ${videoUrl}. Chop vegetables, heat pan, cook until tender, season and serve.`;

export const ingestVideo = async (videoUrl: string) => {
  const transcript = mockTranscriptFromUrl(videoUrl);
  const doc = {
    videoUrl,
    transcript,
    source: "mock" as const,
    createdAt: new Date()
  };
  const result = await transcriptsCollection().insertOne(doc);
  return {
    transcriptId: result.insertedId.toHexString(),
    transcript,
    videoUrl
  };
};

export const getTranscriptById = async (transcriptId: string) => {
  const record = await transcriptsCollection().findOne({
    _id: new ObjectId(transcriptId)
  });
  return record ?? null;
};
