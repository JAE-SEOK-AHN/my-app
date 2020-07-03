import React, { Component } from 'react';
import './App.css';
import Customer from './components/Customer'

const customers = [
  {
  'id' : 1,
  'image' : 'https://placeimg.com/64/64/any',
  'name' : 'Jae-Seok Ahn',
  'birthday' : '980601',
  'gender' : 'Male',
  'job' : 'student' 
  },
  {
  'id' : 2,
  'image' : 'https://placeimg.com/64/64/any',
  'name' : 'Jun-tae Kim',
  'birthday' : '960102',
  'gender' : 'Male',
  'job' : 'baseball player' 
  },
  {
  'id' : 3,
  'image' : 'https://placeimg.com/64/64/any',
  'name' : 'Ji-hoon Choi',
  'birthday' : '951234',
  'gender' : 'Male',
  'job' : 'baseball player' 
  }
]

class App extends Component {
  render() {
    return (
      <div>
        {
          customers.map(c => {return(<Customer id={c.id} image={c.image} name={c.name} birthday={c.birthday} gender={c.gender} job={c.job}/>)})             
        }
        </div>
      );
    }  
  }

  
export default App;
