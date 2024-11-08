"use client";

import { useState } from "react";
import { AiAskInterface } from "@/components/ai-ask-interface";

export default function Home() {
  const [output, setOutput] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const handleResponse = (questions: string) => {
    setOutput(questions);
  };

  const generateText = async (subject: string) => {
    setIsLoading(true);
    try {
      const response = await fetch('/api/chat', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ subject }),
      });

      const data = await response.json();
      if (response.ok) {
        handleResponse(data.questions);
      } else {
        setOutput(data.error);
      }
    } catch (error) {
      console.error('Error:', error);
      setOutput('Failed to generate questions.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <AiAskInterface 
        onResponse={handleResponse} 
        isLoading={isLoading} 
        setIsLoading={setIsLoading} 
        generateText={generateText}
        output={output}
      />
    </main>
  );
}