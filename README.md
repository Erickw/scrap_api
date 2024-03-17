# Scrap API

This is a Rails project demonstrating the integration of Sidekiq for background job processing. In this project, we've set up Sidekiq to handle asynchronous tasks such as fetching data from an external API.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Make sure you have the following software installed on your local machine:

- Ruby
- Rails
- Redis
- Mongo DB

### Installation

1. Clone the repository:

   ```bash
   git clone git@github.com:Erickw/scrap_api.git
2. Create the env file and update with your data:

   ```bash
    cp .env.development.local .env
3. Load the gems

   ```bash
    bundle install
### Usage

1. Start the Rails server:

   ```bash
   rails server
   ```

2. Start Sidekiq:

   ```bash
   bundle exec sidekiq
   ```

3. Visit the Sidekiq dashboard:

   - Once Sidekiq is running, you can access the Sidekiq dashboard by navigating to `http://localhost:3000/sidekiq` in your web browser. Here, you can monitor your queues, view processed jobs, and more.

### Enqueueing Jobs

- To enqueue a job for processing by Sidekiq, simply call the `perform_async` method on your worker class. For example:

  ```ruby
  ExampleWorker.perform_async(*args)
  ```
  The main job from thits project is `FetchWebsiteInfoWorker` called by `WebsiteInfoController``