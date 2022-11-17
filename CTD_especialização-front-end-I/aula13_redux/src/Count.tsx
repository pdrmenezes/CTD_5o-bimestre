import { useSelector } from "react-redux";
import type { RootState } from "./store";

export default function Count() {
  const count = useSelector((state: RootState) => state.counter.value);

  return <p>O valor atual é: {count} </p>;
}
