"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { ScrollArea } from "@/components/ui/scroll-area"
import { SendHorizontal, Sparkles, Loader2 } from "lucide-react"

interface AiAskInterfaceProps {
  onResponse: (questions: string) => void;
  isLoading: boolean;
  setIsLoading: React.Dispatch<React.SetStateAction<boolean>>;
  generateText: (subject: string) => Promise<void>;
  output: string; // Tambahkan prop ini
}

const formatOutput = (output: string) => {
  return output
    .split('\n') // Split by new line
    .map((line, index) => {
      // Check if the line starts with "##"
      if (line.startsWith("##")) {
        return (
          <div key={index} style={{ fontSize: '16px', fontWeight: 'bold' }}>
            {line.replace("## ", "")} {/* Remove the "## " for display */}
          </div>
        );
      }
      // Replace '**' with bold tags for other lines
      const formattedLine = line.replace(/\*\*(.*?)\*\*/g, '$1'); // Remove the bold tags
      return <div key={index}>{formattedLine}</div>; // Render normal text
    });
};

export function AiAskInterface({ onResponse, isLoading, setIsLoading, generateText, output }: AiAskInterfaceProps) {
  const [input, setInput] = useState("")

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!input.trim()) return

    await generateText(input); // Panggil generateText dengan input pengguna
    setInput("")
  }

  return (
    <Card className="w-full max-w-4xl mx-auto">
      <CardHeader>
        <CardTitle className="text-2xl font-bold text-center">Quizmo</CardTitle>
      </CardHeader>
      <CardContent>
        <ScrollArea className="h-[300px] w-full rounded-md border p-4 mb-4">
          {output && (
            <div className="flex items-start space-x-2">
              <Sparkles className="w-6 h-6 mt-1 text-purple-500" />
              <div className="text-sm">{formatOutput(output)}</div>
            </div>
          )}
        </ScrollArea>
        <form onSubmit={handleSubmit} className="flex space-x-2">
          <Input
            type="text"
            placeholder="Masukkan nama subject..."
            value={input}
            onChange={(e) => setInput(e.target.value)}
            className="flex-grow"
          />
          <Button type="submit" disabled={isLoading}>
            {isLoading ? (
              <Loader2 className="w-4 h-4 animate-spin" />
            ) : (
              <SendHorizontal className="w-4 h-4" />
            )}
            <span className="sr-only">Send</span>
          </Button>
        </form>
      </CardContent>
      <CardFooter className="justify-between">
        <Button variant="outline" onClick={() => { 
          setInput(""); 
          onResponse(""); // Clear the output when the button is clicked
        }}>
          Clear Chat
        </Button>
        <p className="text-sm text-muted-foreground">Timses</p>
      </CardFooter>
    </Card>
  )
}