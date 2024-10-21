import { SafeAreaProvider } from "react-native-safe-area-context";
import Layout from "./components/Layout";

export default function App() {
  return (
    <SafeAreaProvider>
      <Layout></Layout>
    </SafeAreaProvider>
  );
}