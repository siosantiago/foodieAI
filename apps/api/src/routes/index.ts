import { Router } from "express";
import { ingestRouter } from "./ingest";
import { recipeRouter } from "./recipes";
import { cookRouter } from "./cook";
import { orderRouter } from "./order";

export const apiRouter = Router();

apiRouter.use("/ingest", ingestRouter);
apiRouter.use("/recipes", recipeRouter);
apiRouter.use("/cook", cookRouter);
apiRouter.use("/order", orderRouter);
