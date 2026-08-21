# Salesforce LWC + Apex CRM

A CRM built on Salesforce using Lightning Web Components for the UI, Apex for backend logic, automation (Flow), and integrations with external systems.

## What it does

- [ ] 1–2 lines: what problem does this CRM solve? (e.g. tracks leads, accounts, and deals through a custom pipeline)
- [ ] List the main objects used (e.g. Account, Contact, Opportunity, custom objects)
- [ ] List 3–5 key features (e.g. lead assignment automation, custom dashboard component, email integration, duplicate detection)

## Demo

Add a screenshot or short GIF/Loom link here showing the app in action.

```
![screenshot](link-to-image)
```

## Tech stack

- **Frontend:** Lightning Web Components (LWC)
- **Backend:** Apex
- **Automation:** Flow / Process Builder
- **Integration:** [name the external system/API you connected, e.g. REST callout to a payment API]
- **Testing:** Jest (LWC), Apex test classes
- **Tooling:** ESLint, Prettier, Husky (pre-commit hooks), SFDX

## Project structure

```
force-app/main/default/
├── classes/       # Apex classes and test classes
├── lwc/           # Lightning Web Components
├── flows/         # Automation
└── objects/       # Custom objects and fields
```

## Setup

1. Clone the repo
   ```
   git clone https://github.com/Himadri-sfdc/salesforce-lwc-apex-crm.git
   ```
2. Authorize a Dev Hub / create a scratch org
   ```
   sf org login web --set-default-dev-hub
   sf org create scratch -f config/project-scratch-def.json -a crm-scratch
   ```
3. Push source to the scratch org
   ```
   sf project deploy start
   ```
4. Assign permission sets (if any) and open the org
   ```
   sf org open
   ```

## Running tests

```
npm run test:unit       # LWC Jest tests
sf apex run test        # Apex tests
```

## What I learned / next steps

- [ ] 1–2 sentences on a technical challenge you solved (governor limits, bulkification, callout handling, etc.)
- [ ] What you'd add next (e.g. more test coverage, CI/CD via GitHub Actions)

## Author

Himadri — [LinkedIn](#) · [Trailhead Profile](#)
