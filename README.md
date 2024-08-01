# Rotational Panels from PLFS
 Creating Rotational Panels from Periodic Labour Force Survey (PLFS) Rounds
The repo contains STATA codes for creating rotational panels from the Periodic Labour Force Survey (PLFS) rounds. The initial PLFS took place in 2017-18, and since then, a new PLFS round has been conducted every year. The PLFS introduced a rotational panel system, where a panel retires after four quarters, and a new one is introduced (onlyfor urban areas). Consequently, an urban household is interviewed for four consecutive quarters. This type of data is most suitable for analyzing mobility, change, or transitions.

As mentioned in the code, we can directly start creating rotational panels by combining visit-wise data (keeping in mind that there are four visits to each sample household). The alternative is to first identify panels in each survey round, then append all panels, and finally, create visit-wise files. I have chosen the second route (which is a bit lengthy) because, firstly, I wanted to create a panel in each round. Additionally, there is an issue with the unique identification of households in the 2017-18 and 2018-19 data. The households interviewed in 2017-18 were reinterviewed in 2018-19 (panels P12, P13, and P14). However, the unique identification IDs in these two rounds differ significantly. This problem was identified by Abdul-Razak, S., & Sahoo, S. (2021). That's why in the codes, I have only combined panels from 2018-19 with panels from 2019-20.

These codes were created in 2021, and since then, there have been more PLFS rounds. If you're interested, you can create more rotational panels. I have run the codes before writing this blog, and to the best of my knowledge, these codes are error-free. Feel free to reach out to me for feedback or if you encounter any errors.
References

Abdul-Razak, S., & Sahoo, S. (2021). Using the rotational panel data from the Periodic Labour Force Survey: A cautionary tale. Available at SSRN 3932499

