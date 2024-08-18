import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import axios from 'axios';

function ProjectDetailPage() {
  const { id } = useParams();
  const [project, setProject] = useState(null);

  useEffect(() => {
    // Fetch project details
    axios.get(`/api/project/${id}`).then(response => {
      setProject(response.data);
    });
  }, [id]);

  return (
    <div>
      {project ? (
        <>
          <h1>{project.name}</h1>
          <p>Budget: {project.budget}</p>
          <p>Status: {project.status}</p>
          <p>Spent: {project.spent}</p>
        </>
      ) : (
        <p>Loading...</p>
      )}
    </div>
  );
}

export default ProjectDetailPage;
