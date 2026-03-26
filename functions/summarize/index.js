export const handler = async (event) => {
  console.log("Event received:", JSON.stringify(event));

  try {
    const body = typeof event.body === "string"
      ? JSON.parse(event.body)
      : event.body || {};

    const text = body.text || "No input provided";

    // Fake summarize (replace with real AI later)
    const summary = text.slice(0, 100);

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Summarized successfully",
        input: text,
        summary: summary,
      }),
    };
  } catch (error) {
    console.error("Error:", error);

    return {
      statusCode: 500,
      body: JSON.stringify({
        message: "Internal server error",
      }),
    };
  }
};