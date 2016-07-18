# Honeycomb Engineering Test - Part Two

## Goal

All systems change as the needs and opportunities they address change over time.
The aim of this test is to see how you approach adapting what you build in the first part of the test to deal with new, emerging requirements.

## The challenge

Now we have the material in our system we want people to be able to pay to have it delivered to broadcasters.

### Broadcasters

These are the Broadcasters we deliver to

* Viacom
* Disney
* Discovery
* ITV
* Channel 4
* Bike Channel
* Horse and Country

### Delivery Products

* Standard Delivery
* Express Delivery

### Rate Card

This is our Rate Card:

* Standard delivery: $10

* Express delivery $20
* Buy two or more express deliveries and the price drops to $15

* Spend over $30 get 10% off

### What we want from you

Provide a means of calculating the cost to a customer of delivering material to broadcasters.

We don't need any UI for this, we just need you to show us how it would work through its API.

## Examples

Based on the Rate card, the following examples should be valid:

* send `WNP/SWCL001/010` to Disney, Discovery, Viacom via Standard Delivery and Horse and Country via Express Delivery

    based on the Rate Card the total should be $45

* send `ZDW/EOWW005/010` to Disney, Discovery, Viacom via Express Delivery
     based on the Rate Card the total should be $49.50

The Rate Card can and will change over time so we need the solution to be flexible.
The same is true of the list of broadcasters we serve.
