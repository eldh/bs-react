import { Component } from 'react'

export class ErrorBoundary extends Component {
  constructor(props) {
    super(props)
    this.state = { error: null }
  }

  componentDidCatch(error, info) {
    this.props.didCatch(error, info)
  }

  static getDerivedStateFromError(error) {
    return { error }
  }

  render() {
    return this.state.error ? this.props.renderError(this.state.error) : this.props.children
  }
}
