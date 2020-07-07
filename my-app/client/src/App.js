import React, { Component } from 'react';
import './App.css';
import Customer from './components/Customer'


class App extends Component { 

  state= {
    customers: ""    
  }

  componentDidMount () {
    this.callApi()      
      .then(res => this.setState({customers : res}))
      .catch(err => console.log(err));
  }

  callApi = async () => {
    const response = await fetch('/api/custormers');
    const body = await response.json();    
    return body;
  }


  render() {
    return (
      <div>
        {
          this.state.customers ? this.state.customers.map(c => {return(<Customer id={c.id} image={c.image} name={c.name} birthday={c.birthday} gender={c.gender} job={c.job}/>)})             
        : ""}
        </div>
      );
    }  
  }

  
export default App;
