import { GoogleGenerativeAI } from "@google/generative-ai";
import { NextResponse } from "next/server";

export async function POST(req: Request) {
    try {
      const apiKey = "AIzaSyC58hEtURklT4ugOrnsjjxJnHeHuxNktQg";
      if (!apiKey) {
        throw new Error("GEMINI_API_KEY is not defined");
      }
      const genAI = new GoogleGenerativeAI(apiKey);
      const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

        const data = await req.json();
        const subject = data.subject;

        const prompt = `Hasilkan pertanyaan sekolah menengah tentang ${subject}.`;
        const result = await model.generateContent(prompt);
        const response = await result.response;
        const output = await response.text();

        return NextResponse.json({ questions: output });
    } catch (error) {
        console.error(error);
        return NextResponse.json({ error: "Failed to generate questions" }, { status: 500 });
    }
}
