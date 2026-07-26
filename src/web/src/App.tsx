import { useEffect, useState } from "react";

export default function App() {
  const [status, setStatus] = useState("checking…");
  useEffect(() => {
    fetch(
      `${import.meta.env.VITE_API_URL ?? "http://localhost:5080"}/health/ready`,
    )
      .then((r) => setStatus(r.ok ? "API healthy ✅" : "API down ❌"))
      .catch(() => setStatus("API unreachable ❌"));
  }, []);
  return <h1>Platform Web — {status}</h1>;
}
