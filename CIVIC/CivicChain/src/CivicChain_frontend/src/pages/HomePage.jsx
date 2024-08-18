import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';

function HomePage() {
  const [projects, setProjects] = useState([]);

  useEffect(() => {
    // Fetch all projects
    axios.get('/api/projects').then(response => {
      setProjects(response.data);
    });
  }, []);

  return (
    <div>
      <h1>Welcome to CivicChain</h1>
      <ul>
        {projects.map(project => (
          <li key={project.id}>
            <Link to={`/project/${project.id}`}>{project.name}</Link>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default HomePage;
