import { increment } from "./CounterSlice";
import { useDispatch } from "react-redux";

export default function Incrementer({ setCount }: any) {
  const dispatch = useDispatch();
  return (
    <>
      <button
        onClick={() => setCount((currentCount: number) => currentCount + 1)}
      >
        Increment with useState
      </button>
      <button onClick={() => dispatch(increment())}>
        Increment with Redux
      </button>
    </>
  );
}
