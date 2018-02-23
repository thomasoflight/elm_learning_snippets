module Element.Area
    exposing
        ( announce
        , announceUrgently
        , aside
        , footer
        , heading
        , mainContent
        , navigation
        )

{-|


# Area Annotations

This module is meant to make accessibility easy! They're sign posts that accessibility software like screen readers can use to navigate your app.

All you have to do is add them to elements in your app where you see fit.

Here's an example of annotating your navigation area:

    import Element.Area as Area

    myNavigation =
        Element.row [ Area.navigation ]
            [-- ..your navigation links
            ]

@docs mainContent, navigation, heading

@docs announce, announceUrgently, aside, footer

-}

import Element exposing (Attribute)
import Internal.Model as Internal exposing (Description(..))


{-| -}
mainContent : Attribute msg
mainContent =
    Internal.Describe Main


{-| -}
aside : Attribute msg
aside =
    Internal.Describe Complementary


{-| -}
navigation : Attribute msg
navigation =
    Internal.Describe Navigation



-- form : Attribute msg
-- form =
--     Internal.Describe Form
-- search : Attribute msg
-- search =
--     Internal.Describe Search


{-| -}
footer : Attribute msg
footer =
    Internal.Describe ContentInfo


{-| This will mark an element as `h1`, `h2`, etc where possible.

Though it's also smart enough to not conflict with existing nodes.

So, this code

    link [ Area.heading 1 ]
        { url = "http://fruits.com"
        , label = text "Best site ever"
        }

will generate

    <a href="http://fruits.com">
        <h1>Best site ever</h1>
    </a>

-}
heading : Int -> Attribute msg
heading =
    Internal.Describe << Heading


{-| Screen readers will announce changes to this element and potentially interrupt any other announcement.
-}
announceUrgently : Attribute msg
announceUrgently =
    Internal.Describe LiveAssertive


{-| Screen readers will announce when changes to this element are made.
-}
announce : Attribute msg
announce =
    Internal.Describe LivePolite
