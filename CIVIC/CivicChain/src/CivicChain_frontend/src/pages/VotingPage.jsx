import React from 'react';
import { useParams } from 'react-router-dom';
import axios from 'axios';

function VotingPage() {
  const { id } = useParams();

  const vote = (option) => {
    axios.post(`/api/vote/${id}`, { option })
      .then(response => {
        alert(`Voted successfully: ${response.data}`);
      })
      .catch(error => {
        alert(`Failed to vote: ${error.message}`);
      });
  };

  return (
    <div>
      <h1>Vote on Project {id}</h1>
      <button onClick={() => vote('approve')}>Approve</button>
      <button onClick={() => vote('reject')}>Reject</button>
    </div>
  );
}

export default VotingPage;
