import React, { Component } from 'react';
import Customer from './components/Customer';
import CustomerAdd from './components/CustomerAdd';
import './App.css';


class App extends Component { 

  constructor(props) {
    super(props);
    this.state = {
      customers: ''     
    }      
  }

  stateRefresh = () => {
    this.setState({
      customers: ''
    });
    this.callApi()      
      .then(res => this.setState({customers : res}))
      .catch(err => console.log(err));
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
        <CustomerAdd stateRefresh={this.stateRefresh}/>
        </div>
      );
    }  
  }

  
export default App;
