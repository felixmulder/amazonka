{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE GeneralizedNewtypeDeriving  #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.RDS.ModifyEventSubscription
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Modifies an existing RDS event notification subscription. Note that you
-- cannot modify the source identifiers using this call; to change source
-- identifiers for a subscription, use the AddSourceIdentifierToSubscription
-- and RemoveSourceIdentifierFromSubscription calls. You can see a list of the
-- event categories for a given SourceType in the Events topic in the Amazon
-- RDS User Guide or by using the DescribeEventCategories action.
--
-- <http://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_ModifyEventSubscription.html>
module Network.AWS.RDS.ModifyEventSubscription
    (
    -- * Request
      ModifyEventSubscription
    -- ** Request constructor
    , modifyEventSubscription
    -- ** Request lenses
    , mesEnabled
    , mesEventCategories
    , mesSnsTopicArn
    , mesSourceType
    , mesSubscriptionName

    -- * Response
    , ModifyEventSubscriptionResponse
    -- ** Response constructor
    , modifyEventSubscriptionResponse
    -- ** Response lenses
    , mesrEventSubscription
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.RDS.Types
import qualified GHC.Exts

data ModifyEventSubscription = ModifyEventSubscription
    { _mesEnabled          :: Maybe Bool
    , _mesEventCategories  :: [Text]
    , _mesSnsTopicArn      :: Maybe Text
    , _mesSourceType       :: Maybe Text
    , _mesSubscriptionName :: Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'ModifyEventSubscription' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'mesEnabled' @::@ 'Maybe' 'Bool'
--
-- * 'mesEventCategories' @::@ ['Text']
--
-- * 'mesSnsTopicArn' @::@ 'Maybe' 'Text'
--
-- * 'mesSourceType' @::@ 'Maybe' 'Text'
--
-- * 'mesSubscriptionName' @::@ 'Text'
--
modifyEventSubscription :: Text -- ^ 'mesSubscriptionName'
                        -> ModifyEventSubscription
modifyEventSubscription p1 = ModifyEventSubscription
    { _mesSubscriptionName = p1
    , _mesSnsTopicArn      = Nothing
    , _mesSourceType       = Nothing
    , _mesEventCategories  = mempty
    , _mesEnabled          = Nothing
    }

-- | A Boolean value; set to true to activate the subscription.
mesEnabled :: Lens' ModifyEventSubscription (Maybe Bool)
mesEnabled = lens _mesEnabled (\s a -> s { _mesEnabled = a })

-- | A list of event categories for a SourceType that you want to subscribe
-- to. You can see a list of the categories for a given SourceType in the
-- Events topic in the Amazon RDS User Guide or by using the
-- DescribeEventCategories action.
mesEventCategories :: Lens' ModifyEventSubscription [Text]
mesEventCategories =
    lens _mesEventCategories (\s a -> s { _mesEventCategories = a })

-- | The Amazon Resource Name (ARN) of the SNS topic created for event
-- notification. The ARN is created by Amazon SNS when you create a topic
-- and subscribe to it.
mesSnsTopicArn :: Lens' ModifyEventSubscription (Maybe Text)
mesSnsTopicArn = lens _mesSnsTopicArn (\s a -> s { _mesSnsTopicArn = a })

-- | The type of source that will be generating the events. For example, if
-- you want to be notified of events generated by a DB instance, you would
-- set this parameter to db-instance. if this value is not specified, all
-- events are returned. Valid values: db-instance | db-parameter-group |
-- db-security-group | db-snapshot.
mesSourceType :: Lens' ModifyEventSubscription (Maybe Text)
mesSourceType = lens _mesSourceType (\s a -> s { _mesSourceType = a })

-- | The name of the RDS event notification subscription.
mesSubscriptionName :: Lens' ModifyEventSubscription Text
mesSubscriptionName =
    lens _mesSubscriptionName (\s a -> s { _mesSubscriptionName = a })

newtype ModifyEventSubscriptionResponse = ModifyEventSubscriptionResponse
    { _mesrEventSubscription :: Maybe EventSubscription
    } deriving (Eq, Show, Generic)

-- | 'ModifyEventSubscriptionResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'mesrEventSubscription' @::@ 'Maybe' 'EventSubscription'
--
modifyEventSubscriptionResponse :: ModifyEventSubscriptionResponse
modifyEventSubscriptionResponse = ModifyEventSubscriptionResponse
    { _mesrEventSubscription = Nothing
    }

mesrEventSubscription :: Lens' ModifyEventSubscriptionResponse (Maybe EventSubscription)
mesrEventSubscription =
    lens _mesrEventSubscription (\s a -> s { _mesrEventSubscription = a })

instance ToPath ModifyEventSubscription where
    toPath = const "/"

instance ToQuery ModifyEventSubscription

instance ToHeaders ModifyEventSubscription

instance AWSRequest ModifyEventSubscription where
    type Sv ModifyEventSubscription = RDS
    type Rs ModifyEventSubscription = ModifyEventSubscriptionResponse

    request  = post "ModifyEventSubscription"
    response = xmlResponse

instance FromXML ModifyEventSubscriptionResponse where
    parseXML c = ModifyEventSubscriptionResponse
        <$> c .: "EventSubscription"
