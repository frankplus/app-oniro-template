# Oniro / OpenHarmony App Template

This repository provides a **Hello World application template** for building apps with **Oniro** and **OpenHarmony**.
It is designed as a clean starting point for your own projects and was featured in the video tutorial:

 *AI-Assisted OpenHarmony App Development with VS Code and Oniro IDE*


## About the Template

The project is a minimal **Hello World** app that you can build and run directly on Oniro/OpenHarmony.
It includes all the necessary configuration and boilerplate so you can focus on developing your application logic.

From this template, we demonstrated how to build a **Notes app** from scratch using only an **AI agent prompt**.


## Tutorial Example: Notes App

In the tutorial, we started with this template and provided the following AI prompt:

```text
Create a note taking app for OpenHarmony with simple input and storage, and a view of the list of saved notes. In ArkTS (see #file:typescript-to-arkts-migration-guide.md for reference). 
Use the following command to build the project and check for Errors: `/home/francesco/command-line-tools/bin/hvigorw assembleHap --mode module -p product=default --stacktrace --no-parallel --no-daemon`
```

The AI agent generated a complete Notes app implementation based on this template.
You can find the resulting code in the `notes_app` branch of this repository.

## Branches

* **`main`** → Base **Hello World template**
* **`notes_app`** → Example Notes app generated from the template with AI assistance

## Resources

* [Oniro Project Documentation](https://docs.oniroproject.org/)

## License

This project is released under the [Apache 2.0 License](LICENSE).
