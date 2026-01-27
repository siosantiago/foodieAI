import { MongoClient, Db } from "mongodb";
import { env } from "../config/env";

let client: MongoClient | null = null;
let db: Db | null = null;

export const connectMongo = async (): Promise<Db> => {
  if (db) return db;
  if (!env.mongoUri) {
    throw new Error("Missing MONGODB_URI in environment.");
  }
  client = new MongoClient(env.mongoUri);
  await client.connect();
  db = client.db();
  return db;
};

export const getDb = (): Db => {
  if (!db) {
    throw new Error("MongoDB not connected yet.");
  }
  return db;
};
