import React from "react";
import { Link } from "react-router-dom";
import './navbar.css';

const Navbar = () => {
  return (
    <nav>
      <ul>
        <li>
          <Link to="/teams">Teams</Link>
        </li>
        <li>
          <Link to="/findPlayers">Find Players</Link>
        </li>
      </ul>
    </nav>
  );
};

export default Navbar;
