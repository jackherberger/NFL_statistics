import React from "react";
import {
  BrowserRouter,
  Routes,
  Route
} from "react-router-dom";
import Navbar from "./components/Navbar"; // Make sure this path is correct
import Teams from "./pages/teams";
import FindPlayers from "./pages/findPlayers";

function App() {
  return (
    <div className="App">
      <BrowserRouter>
        <Navbar /> {/* Include Navbar here */}
        <Routes>
          <Route path="/teams" element={<Teams/>}/>
          <Route path="/findPlayers" element={<FindPlayers/>}/>
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;
