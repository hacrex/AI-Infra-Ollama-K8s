# Project Status

## Portfolio Scope

A Kubernetes reference deployment for private local-LLM inference using Ollama and Open WebUI, with persistent model storage and an optional NVIDIA GPU overlay.

## Intended Deployment Path

Run `kubectl apply -k .` in a dedicated test cluster. The GPU overlay requires nodes labelled `accelerator=nvidia` and a working NVIDIA device plugin.

## Safety and Validation

This repository contains **non-production reference configuration** unless its deployment guide explicitly states otherwise. Review every Terraform plan and Kubernetes manifest in an isolated account, project, subscription, compartment, or cluster before use. Do not commit credentials, cloud access keys, API tokens, or live state files.

## What to Discuss in an Interview

Explain the architecture, the operational trade-offs, how you would validate a change, how you would roll it back, and the parts that require organisation-specific configuration.
